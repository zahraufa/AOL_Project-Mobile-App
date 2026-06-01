/* eslint-disable */
import { Injectable } from '@nestjs/common';
import { Prisma, users } from '@prisma/client';
import { PrismaService } from 'src/prisma/prisma.service';
import { usercreateDTO } from './dto/usercreateDTO';

@Injectable()
export class UsersService {
    private _prismaService: PrismaService;
    constructor(prismaService: PrismaService) {
        this._prismaService = prismaService;    
    }

    findAll(): Promise<Pick<users, 'User_ID' | 'Username' | 'User_email' | 'User_password' | 'User_PhoneNumber'>[]>{
        return this._prismaService.users.findMany();
    }

    findOne(User_ID: number){
        return this._prismaService.users.findUnique({
            where: {
                User_ID: User_ID
            }
        })
    }

    create(body: usercreateDTO){
        return this._prismaService.users.create({
            data: body as Prisma.usersCreateInput
        })
    }

    update(User_ID: number, body: usercreateDTO){
        return this._prismaService.users.update({
            where: {
                User_ID: User_ID
            },
            data: body as Prisma.usersUpdateInput
        })
    }

    delete(User_ID: number){
        return this._prismaService.users.delete({
            where: {
                User_ID: User_ID
            }
        })
    }
}
