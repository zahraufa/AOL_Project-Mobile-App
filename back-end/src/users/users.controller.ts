import { Body, Controller, Delete, Get, Param, Patch, Post, Put, Req, UseGuards } from '@nestjs/common';
import { UsersService } from './users.service';
import { UserCreateDto } from './dto/usercreateDTO';
import { ApiBody } from '@nestjs/swagger';
import { jwtGuards } from 'src/autho/guards/jwt.guards';
import { userUpdateDto } from './dto/UserUpdateDto';

@Controller('users')
export class UsersController {
    private _usersService: UsersService;

    constructor(usersService: UsersService) {
        this._usersService = usersService;
    }

    @UseGuards(jwtGuards)
    @Get('profile')
    getProfile(@Req() req){
        return this._usersService.getProfile(req.user['sub']);
    }

    @UseGuards(jwtGuards)
    @Get('current')
    getCurrent(@Req() req){
        return req.user;
    }

    @UseGuards(jwtGuards)
    @Patch('update-profile')
    updateProfile(@Req() req, @Body() body: userUpdateDto){
        return this._usersService.updateProfile(Number(req.user['sub']), body);
    }

    
}


