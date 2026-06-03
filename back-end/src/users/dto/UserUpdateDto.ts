import { ApiProperty } from "@nestjs/swagger";
import { IsEmail, IsOptional, Matches } from "class-validator";

export class userUpdateDto {
    @IsOptional()
    @ApiProperty()
    Username?: string

    @IsOptional()
    @IsEmail()
    @ApiProperty()
    User_email?: string;
    
    @IsOptional()
    @Matches(/^08[0-9]{8,13}$/)
    @ApiProperty()
    User_PhoneNumber?: string;
}