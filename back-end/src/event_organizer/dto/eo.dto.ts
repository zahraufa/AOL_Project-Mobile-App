import { IsOptional, IsString } from "class-validator";

export class FindForEODto {
    @IsOptional()
    @IsString()
    category?: string
}