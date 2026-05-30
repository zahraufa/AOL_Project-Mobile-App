import { Body, Controller, Delete, Get, Param, Post, Put } from '@nestjs/common';
import { UsersService } from './users.service';
import { usercreateDTO } from './dto/usercreateDTO';
import { ApiBody } from '@nestjs/swagger';

@Controller('users')
export class UsersController {
    private _usersService: UsersService;

    constructor(usersService: UsersService) {
        this._usersService = usersService;
    }

    @Get()
    async findAll(){
        const data = await this._usersService.findAll();
        return {
            status: 6767,
            data: data
        }
    }

    @Get(':id')
    async findOne(@Param('id') User_ID: string){
        const data = await this._usersService.findOne(Number(User_ID));
        return {
            status: 6767,
            data: data
        }
    }

    @Post()
    @ApiBody({
        description: "Butuh body dengan format sini",
        type: usercreateDTO
    })
    async create(@Body() body:usercreateDTO){
        const data = await this._usersService.create(body)
        return {
            status: 6767,
            data: data
        }
    }
    @Put(':id')
    @ApiBody({
        description: "Need body",
        type: usercreateDTO
    })
    async update(@Param('id') User_ID: string, @Body() body: usercreateDTO){
        const data = await this._usersService.update(Number(User_ID), body)
        return {
            status: 6767,
            data: data
        }
    }

    @Delete('id')
    async delete (@Param('id') User_Id: string){
        const data = await this._usersService.delete(Number(User_Id))
        return {
            status: 6767,
            data: data
        }
    }
}