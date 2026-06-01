import { Module } from '@nestjs/common';
import { AuthoService } from './autho.service';
import { AuthoController } from './autho.controller';

@Module({
  providers: [AuthoService],
  controllers: [AuthoController],
  exports: [AuthoService]
})
export class AuthoModule {}
