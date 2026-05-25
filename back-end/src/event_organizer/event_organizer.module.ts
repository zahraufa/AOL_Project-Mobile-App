import { Module } from '@nestjs/common';
import { EventOrganizerService } from './event_organizer.service';
import { EventOrganizerController } from './event_organizer.controller';

@Module({
  providers: [EventOrganizerService],
  controllers: [EventOrganizerController]
})
export class EventOrganizerModule {}
