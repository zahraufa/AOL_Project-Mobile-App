import { Test, TestingModule } from '@nestjs/testing';
import { AuthoService } from './autho.service';

describe('AuthoService', () => {
  let service: AuthoService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [AuthoService],
    }).compile();

    service = module.get<AuthoService>(AuthoService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});


