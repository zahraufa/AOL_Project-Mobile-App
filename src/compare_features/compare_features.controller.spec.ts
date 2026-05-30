import { Test, TestingModule } from '@nestjs/testing';
import { CompareFeaturesController } from './compare_features.controller';

describe('CompareFeaturesController', () => {
  let controller: CompareFeaturesController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [CompareFeaturesController],
    }).compile();

    controller = module.get<CompareFeaturesController>(CompareFeaturesController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
