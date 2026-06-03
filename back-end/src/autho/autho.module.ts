 /* eslint-disable */
import { Module } from '@nestjs/common';
import { AuthoController } from './autho.controller';
import { PrismaModule } from 'src/prisma/prisma.module';
import { PassportModule } from '@nestjs/passport';
import { JwtModule } from '@nestjs/jwt';
import { AuthoService } from './autho.service';
import { JwtStrategy } from './jwt.strategy';

  @Module({
    imports:[
      PrismaModule, PassportModule,
      JwtModule.register({
        secret: process.env.JWT_SECRET as string,
        signOptions: { expiresIn: process.env.JWT_EXPIRES_IN as any },
      }),
      
    ],
   controllers: [AuthoController],
   providers: [ AuthoService, JwtStrategy]

  })
 export class AuthoModule {}
