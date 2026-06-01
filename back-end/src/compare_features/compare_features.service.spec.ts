import { Test, TestingModule } from '@nestjs/testing';
import { CompareFeaturesService } from './compare_features.service';

describe('CompareFeaturesService', () => {
  let service: CompareFeaturesService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [CompareFeaturesService],
    }).compile();

    service = module.get<CompareFeaturesService>(CompareFeaturesService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
