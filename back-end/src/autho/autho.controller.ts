import { Controller, Post, Body, UseGuards, Get, Req } from '@nestjs/common';
import { AuthoService } from './autho.service';
import { AuthoSignupDto, AuthoLoginDto } from './dto/auth.dto';
import { jwtGuards } from './guards/jwt.guards';

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

    @Post('login')
    async login(@Body() body: AuthoLoginDto) {
        return this._authoService.login(body);
    }

    @UseGuards(jwtGuards)
    @Get('profile')
    async getProfile(@Req() req){
        return req.user;
    }
}

