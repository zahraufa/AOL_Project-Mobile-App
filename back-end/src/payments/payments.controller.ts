import { Controller, Post, Body, UseGuards, Param, Patch} from '@nestjs/common';
import { PaymentsService } from './payments.service';
import { CreatePaymentDTO } from './dto/payments.dto';
import { jwtGuards } from 'src/autho/guards/jwt.guards';

@Controller('payments')
export class PaymentsController {
    private _paymentsService: PaymentsService;

    constructor(PaymentsService: PaymentsService) {
        this._paymentsService = PaymentsService;
    }

    @UseGuards(jwtGuards)
    @Post()
    createPayment(@Body() dto: CreatePaymentDTO) {
        return this._paymentsService.createPayment(dto);
    }

    @Patch(':id/success')
    paymentSuccess(@Param('id') id: string) {
        return this._paymentsService.paymentSuccess(Number(id));
    }

    @Patch(':id/failed')
    paymentFailed(@Param('id') id: string) {
        return this._paymentsService.paymentFailed(Number(id));
    }
}
