import { ApiProperty } from "@nestjs/swagger";
import { IsEmail, IsString, Matches, MinLength, IsNotEmpty } from "class-validator";


export class AuthoLoginDto {
    @IsNotEmpty()
    @IsEmail()
    @ApiProperty()
    User_email: string;

    @IsNotEmpty()
    @ApiProperty()
    User_password: string;
}

export class AuthoSignupDto {
    @IsNotEmpty()
    @IsString()
    @ApiProperty()
    Username: string;

    @IsNotEmpty()
    @IsEmail()
    @ApiProperty()
    User_email: string;

    @IsNotEmpty()
    @MinLength(6)
    @ApiProperty()
    User_password: string;

    @IsNotEmpty()
    @Matches(/^08[0-9]{8,13}$/)
    @ApiProperty()
    User_PhoneNumber: string;
}