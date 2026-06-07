import {IsEnum,IsInt,IsNotEmpty} from 'class-validator';

import {payments_Payment_Method} from '@prisma/client';

export class CreatePaymentDTO {

  @IsInt()
  @IsNotEmpty()
  transaction_id: number;

  @IsEnum(
    payments_Payment_Method,
  )
  payment_method:
    payments_Payment_Method;
}