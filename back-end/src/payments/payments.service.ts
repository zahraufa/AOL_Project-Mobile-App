import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/prisma/prisma.service';
import { CreatePaymentDTO } from './dto/payments.dto';
import { payments_Payment_Status, transaction_Transaction_Status } from '@prisma/client/wasm';

@Injectable()
export class PaymentsService {
    private _PrismaService: PrismaService;

    constructor(PrismaService: PrismaService) {
        this._PrismaService = PrismaService;
    }

    async createPayment(dto: CreatePaymentDTO){
        const transaction = await this._PrismaService.transaction.findUnique({
            where: {
                Transaction_ID: dto.transaction_id,
            },
            include: {
                payments: true
            }
        })

        if(!transaction){
            throw new Error('Transaction not found');
        }

        if(transaction.payments){
            throw new Error('Payment already exists for this transaction');
        }

        const payment = await this._PrismaService.payments.create({
            data: {
                Transaction_ID: dto.transaction_id,
                Payment_Method: dto.payment_method,
                Amount: transaction.Total_price,
            }
        })

        return {
            message: 'Payment created successfully',
            data: payment,
        
        }
    }

        async paymentSuccess(paymentId: number){
            const payment = await this._PrismaService.payments.update({
                where: {
                    Payments_ID: paymentId,
                },
                data: {
                    Payment_Status: payments_Payment_Status.Succeed,
                },
            });

            await this._PrismaService.transaction.update({
                where: {
                    Transaction_ID: payment.Transaction_ID,
                },
                data: {
                    Transaction_Status: transaction_Transaction_Status.Success,
                },
            });

            return {
                message: 'Payment marked as successful',
            }
        }

        async paymentFailed(paymentId: number){
            const payment = await this._PrismaService.payments.update({
                where: {
                    Payments_ID: paymentId,
                },
                data: {
                    Payment_Status: payments_Payment_Status.Failed,
                }
            });

            await this._PrismaService.transaction.update({
                where: {
                    Transaction_ID: payment.Transaction_ID,
                },
                data: {
                    Transaction_Status: transaction_Transaction_Status.Cancelled,
                },
            });

            return {
                message: 'Payment marked as failed',
            }
        }
}
