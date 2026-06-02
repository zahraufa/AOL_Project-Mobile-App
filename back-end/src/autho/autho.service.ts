import { BadRequestException, ConflictException, Injectable, UnauthorizedException } from '@nestjs/common';
import { UsersService } from 'src/users/users.service';
import { AuthoSignupDto, AuthoLoginDto } from './dto/auth.dto';
import { PrismaService } from 'src/prisma/prisma.service';
import * as bcrypt from 'bcrypt';
import { JwtService } from '@nestjs/jwt/dist/jwt.service';

@Injectable()
export class AuthoService {
    private _prismaService: PrismaService;

    private _jwtService: JwtService;

    constructor(prismaService: PrismaService, jwtService: JwtService) {
        this._prismaService = prismaService;
        this._jwtService = jwtService;
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

    async login(body: AuthoLoginDto) {
        const user = await this._prismaService.users.findUnique({
            where: {
                User_email: body.User_Email,
            }
        })

        if(!user){
            throw new BadRequestException('Invalid email or password');
        }

        const isPasswordValid = await bcrypt.compare(body.User_password, user.User_password);

        if(!isPasswordValid){
            throw new UnauthorizedException('Invalid email or password');
        }

        const payload = { User_ID: user.User_ID, User_email: user.User_email };
        const token = this._jwtService.sign(payload);

        return{
            message: 'Login successful',
            token: token,

            user: {
                User_ID: user.User_ID,
                Username: user.Username,
                User_email: user.User_email,
            }
        }
    }
}


