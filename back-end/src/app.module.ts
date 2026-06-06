/* eslint-disable */
import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { UsersModule } from './users/users.module';
import { EventOrganizerModule } from './event_organizer/event_organizer.module';
import { AuthoModule } from './autho/autho.module';
import { PrismaModule } from './prisma/prisma.module';
import { ConfigModule } from '@nestjs/config';
import { TransactionModule } from './transaction/transaction.module';

@Module({
  // imports: [UsersModule, EventOrganizerModule, CompareFeaturesModule, TransactionModule, AuthoModule, PrismaModule],
  // controllers: [AppController],
  // providers: [AppService, CompareFeaturesService],
  imports: [ 
    ConfigModule.forRoot({
      isGlobal: true,
    }),
    PrismaModule, UsersModule, AuthoModule, EventOrganizerModule, TransactionModule
  ],
})
export class AppModule {}
