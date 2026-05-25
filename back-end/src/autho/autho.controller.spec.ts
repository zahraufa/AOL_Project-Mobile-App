import { Test, TestingModule } from '@nestjs/testing';
import { AuthoController } from './autho.controller';

describe('AuthoController', () => {
  let controller: AuthoController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [AuthoController],
    }).compile();

    controller = module.get<AuthoController>(AuthoController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
