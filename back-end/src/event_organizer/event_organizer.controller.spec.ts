import { Test, TestingModule } from '@nestjs/testing';
import { EventOrganizerController } from './event_organizer.controller';

describe('EventOrganizerController', () => {
  let controller: EventOrganizerController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [EventOrganizerController],
    }).compile();

    controller = module.get<EventOrganizerController>(EventOrganizerController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
