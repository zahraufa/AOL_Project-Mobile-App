import { Controller, Get, Param, Query } from '@nestjs/common';
import { EventOrganizerService } from './event_organizer.service';

@Controller('event-organizer')
export class EventOrganizerController {
    private _eventOrganizerService: EventOrganizerService;

    constructor(eventOrganizerService: EventOrganizerService) {
        this._eventOrganizerService = eventOrganizerService;
    }

    @Get()
    getALLEO(){
        return this._eventOrganizerService.getAllEO();
    }

    @Get('comparing')
    compareEOs(@Query('id') EO_IDs: string){
        return this._eventOrganizerService.compareEOs(EO_IDs);
    }

    @Get(':id')
    getEOByID(@Param('id') EO_ID: string){
        return this._eventOrganizerService.getEOByID(Number(EO_ID));
    }
}
