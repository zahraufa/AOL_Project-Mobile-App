import { IsArray, IsDateString, IsInt, IsNotEmpty, IsOptional, IsString, isString } from "class-validator";

export class transactionDto {
    @IsDateString()
    @IsNotEmpty()
    event_date: Date;

    @IsString()
    @IsNotEmpty()
    event_location: string;

    @IsInt()
    @IsNotEmpty()
    eo_id: number;

    @IsInt()
    @IsNotEmpty()
    package_id: number;

    @IsArray()
    @IsOptional()
    selected_services?: number[];
}