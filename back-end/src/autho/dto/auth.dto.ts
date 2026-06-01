import { ApiProperty } from "@nestjs/swagger";

export class AuthoLoginDto {
    @ApiProperty()
    Username: string;
    @ApiProperty()
    User_password: string;
}

export class AuthoSignupDto {
    @ApiProperty()
    Username: string;
    @ApiProperty()
    User_email: string;
    @ApiProperty()
    User_password: string;
    @ApiProperty()
    User_PhoneNumber: string;
}