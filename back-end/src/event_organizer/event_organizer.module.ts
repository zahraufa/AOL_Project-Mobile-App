import { Module } from '@nestjs/common';
import { EventOrganizerService } from './event_organizer.service';
import { EventOrganizerController } from './event_organizer.controller';
import { PrismaModule } from 'src/prisma/prisma.module';
import { UsersModule } from 'src/users/users.module';
import { AuthoModule } from 'src/autho/autho.module';

@Module({
  imports: [PrismaModule, AuthoModule, UsersModule],
  providers: [EventOrganizerService],
  controllers: [EventOrganizerController]
})
export class EventOrganizerModule {}
