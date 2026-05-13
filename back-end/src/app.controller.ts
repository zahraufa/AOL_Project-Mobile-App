import { Controller, Get } from '@nestjs/common';
import { AppService } from './app.service';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get()
  getHello(): string {
    return this.appService.getHello();
  }
  dfodncvosd
  sackdnv
  cskdvjdovjd

  @Get()
  getHello(): string {
    return this.appService.getHello();
  }
}
