import { Controller, Get, Param, Query } from '@nestjs/common';
import { EventOrganizerService } from './event_organizer.service';
import { FindForEODto } from './dto/eo.dto';

// ini untuk get all eo
@Controller('event-organizer')
export class EventOrganizerController {
    private _eventOrganizerService: EventOrganizerService;

    constructor(eventOrganizerService: EventOrganizerService) {
        this._eventOrganizerService = eventOrganizerService;
    }

    @Get()
    getALLEO(@Query() query: FindForEODto){
        return this._eventOrganizerService.getAllEO(query);
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
