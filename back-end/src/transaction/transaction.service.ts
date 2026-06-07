/* eslint-disable */

import { BadRequestException, Injectable } from '@nestjs/common';
import { transactionDto } from './dto/transaction-dto';
import { PrismaService } from 'src/prisma/prisma.service';

@Injectable()
export class TransactionService {
    private _PrismaService: PrismaService;

    constructor(prismaService: PrismaService) {
        this._PrismaService = prismaService;
    }

    async buildTransaction(dto: transactionDto, user_id: number) {
        const selected_pack = await this._PrismaService.eo_package.findFirst({
            where: {
                Package_ID: dto.package_id,
                EO_ID: dto.eo_id,
            }
        })

        if(!selected_pack) {
            throw new BadRequestException("Package not found");
        }

        const selected_serv = await this._PrismaService.event_organizer_services.findMany({
            where: {

                Event_Organizer_ID: dto.eo_id,
                Main_Services_ID: {
                    in: dto.selected_services || []
                },
                Is_Required: false
            },
            include: {
                services: true
            },
        })

        if (
        selected_serv.length !==
        (dto.selected_services?.length || 0)) {
        throw new BadRequestException('Some selected add-ons are not available for this Event Organizer');
}

        const TotalAddOns = selected_serv.reduce((total, service) => total + Number(service.Service_Price || 0), 0);
        
        const totalPrice = Number(selected_pack.Package_Price) + TotalAddOns;

        const transaction = await this._PrismaService.transaction.create({
            data: {

                Event_Date:
                new Date(dto.event_date),
                Event_Location:dto.event_location,
                Total_price:totalPrice,
                User_ID:user_id,
                Event_Organizer_ID:dto.eo_id,
                Package_ID:dto.package_id,

                selected_services: {
                create:
                    selected_serv.map((service) => ({
                        EO_Service_ID:service.EO_services_ID,
                    })),
                },
            },

            include: {
                
                selected_services: {
                include: {
                    event_organizer_services: {
                    include: {
                        services: true,
                    },
                    },
                },
                },
                eo_package: true,
            },
            });

        return {
        message:
            'Transaction created successfully',

        data: {
            transaction_id: transaction.Transaction_ID,

            package: transaction.eo_package?.Package_Name,

            total_price: transaction.Total_price,

            selected_add_ons:transaction.selected_services.map((service) => ({
                service_name:
                    service.event_organizer_services.services.Service_name,
                })),
        },
    };
    }
}
