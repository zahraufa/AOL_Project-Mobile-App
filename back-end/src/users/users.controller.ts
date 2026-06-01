import { Body, Controller, Delete, Get, Param, Post, Put } from '@nestjs/common';
import { UsersService } from './users.service';
import { UserCreateDto } from './dto/UserCreateDto';
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
        return data
    }

    @Get(':id')
    async findOne(@Param('id') User_ID: string){
        const data = await this._usersService.findOne(Number(User_ID));
        return data
    }

    @Post()
    @ApiBody({
        description: "Butuh body dengan format sini",
        type: UserCreateDto
    })

    async create(@Body() body:UserCreateDto){
          try {
    console.log(body);

    const data =
      await this._usersService.create(body);

    return data;
  } catch (error) {
    console.log(error);

    return error;
  }
    }
    // async create(@Body() body:UserCreateDto){
    //     const data = await this._usersService.create(body)
    //     return data
    // }
    
    @Put(':id')
    @ApiBody({
        description: "Need body",
        type: UserCreateDto
    })
    async update(@Param('id') User_ID: string, @Body() body: UserCreateDto){
        const data = await this._usersService.update(Number(User_ID), body)
        return data
    }

    @Delete(':id')
    async delete (@Param('id') User_Id: string){
        const data = await this._usersService.delete(Number(User_Id))
        return data
    }
}