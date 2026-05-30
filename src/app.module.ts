import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { UsersModule } from './users/users.module';
import { EventOrganizerModule } from './event_organizer/event_organizer.module';
import { CompareFeaturesService } from './compare_features/compare_features.service';
import { CompareFeaturesModule } from './compare_features/compare_features.module';
import { TransactionModule } from './transaction/transaction.module';
import { AuthoModule } from './autho/autho.module';
import { PrismaModule } from './prisma/prisma.module';

@Module({
  imports: [UsersModule, EventOrganizerModule, CompareFeaturesModule, TransactionModule, AuthoModule, PrismaModule],
  controllers: [AppController],
  providers: [AppService, CompareFeaturesService],
})
export class AppModule {}
