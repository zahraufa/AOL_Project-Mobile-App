import { BadRequestException, ConflictException, Injectable } from '@nestjs/common';
import { UsersService } from 'src/users/users.service';
import { AuthoSignupDto, AuthoLoginDto } from './dto/auth.dto';
import { PrismaService } from 'src/prisma/prisma.service';
import * as bcrypt from 'bcrypt';

@Injectable()
export class AuthoService {
    private _prismaService: PrismaService;

    constructor(prismaService: PrismaService) {
        this._prismaService = prismaService;
    }

    async signUp(body: AuthoSignupDto) {
        const UserisExist = await this._prismaService.users.findUnique({
            where: {
                User_email: body.User_email,
            }
        })

        if(UserisExist) {
            throw new ConflictException('Email already exists');
        }

        const newUser = await this._prismaService.users.create({
            data: {
                Username: body.Username,
                User_email: body.User_email,
                User_password: await bcrypt.hash(body.User_password, 10),
                User_PhoneNumber: body.User_PhoneNumber,
            }
        })

        return {
            message: 'Sign up successful',
            user: {
                User_ID: newUser.User_ID,
                Username: newUser.Username,
                User_email: newUser.User_email,
                User_PhoneNumber: newUser.User_PhoneNumber,
            }
        }
    }
}


