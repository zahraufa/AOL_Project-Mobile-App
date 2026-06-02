import { Controller, Post, Body } from '@nestjs/common';
import { AuthoService } from './autho.service';
import { AuthoSignupDto } from './dto/auth.dto';

@Controller('autho')
export class AuthoController {
    private _authoService: AuthoService;

    constructor(authoService: AuthoService) {
        this._authoService = authoService;
    }

    @Post('/signup')
    async signUp(@Body() body: AuthoSignupDto) {
        return this._authoService.signUp(body);
    }
}
