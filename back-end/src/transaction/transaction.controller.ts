import { Body, Controller, Get, Post, Req, UseGuards } from '@nestjs/common';
import { TransactionService } from './transaction.service';
import { jwtGuards } from 'src/autho/guards/jwt.guards';
import { transactionDto } from './dto/transaction-dto';

@Controller('transaction')
export class TransactionController {
    private _TransactionService: TransactionService;

    constructor(TransactionService: TransactionService) {
        this._TransactionService = TransactionService;
    }

    @UseGuards(jwtGuards)
    @Post()
    buildTransaction(@Body() dto: transactionDto, @Req() req) {
        return this._TransactionService.buildTransaction(dto, req.user.sub);
        
    }
}
    