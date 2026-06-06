/* eslint-disable */
import { Injectable, NotFoundException } from '@nestjs/common';
import { Prisma, users } from '@prisma/client';
import { PrismaService } from 'src/prisma/prisma.service';
import { UserCreateDto } from './dto/usercreateDTO';
import { userUpdateDto } from './dto/UserUpdateDto';


@Injectable()
export class UsersService {
    private _prismaService: PrismaService;
    
    constructor(prismaService: PrismaService) {
        this._prismaService = prismaService;    
    }

    async getProfile(userID: number){
        const user = await this._prismaService.users.findUnique({
            where: {
                User_ID: userID
            }
        });
        
        if(!user){
            throw new NotFoundException('User not found');
        }

        return {
            User_ID: user.User_ID,
            Username: user.Username,
            User_email: user.User_email,
            User_PhoneNumber: user.User_PhoneNumber,
            Created_at: user.Created_at
        }
    }

    async updateProfile(userID: number, updateData: userUpdateDto){
        const user = await this._prismaService.users.findUnique({
            where: {
                User_ID: userID
            }
        });

        if(!user){
            throw new NotFoundException('User not found');
        }

        const updatedUser = await this._prismaService.users.update({
            where: {
                User_ID: userID
            },
            data: updateData
        });

        return{
            message: 'Profile updated!',
            user: {
                User_ID: updatedUser.User_ID,
                Username: updatedUser.Username,
                User_email: updatedUser.User_email,
                User_PhoneNumber: updatedUser.User_PhoneNumber,

            }
        }   
    }
}
