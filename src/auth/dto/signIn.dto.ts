import { Transform } from "class-transformer";
import { IsEmail, IsNotEmpty, IsString, MinLength } from "class-validator";

export class SignInDto {
    @IsEmail()
    email: string;
    
    @Transform(({ value }) => value.trim())
    @IsString()
    @MinLength(6)
    @IsNotEmpty()
    password: string;
}