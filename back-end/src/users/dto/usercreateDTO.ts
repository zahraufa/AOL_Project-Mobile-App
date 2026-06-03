/* eslint-disable */
import { ApiProperty } from "@nestjs/swagger";

export class UserCreateDto {
    @ApiProperty()
    Username: string;
    @ApiProperty()
    User_email: string;
    @ApiProperty()
    User_password: string;
    @ApiProperty()
    User_PhoneNumber: string;
}