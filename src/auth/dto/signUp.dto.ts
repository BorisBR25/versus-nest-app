import { Transform } from "class-transformer";
import { IsEmail, IsNotEmpty, IsString, MinLength } from "class-validator";

export class SignUpDto {

    @Transform(({ value }) => value.trim())
    @IsString()
    @IsNotEmpty()
    name: string;

    @IsEmail()
    email: string;
    
    @Transform(({ value }) => value.trim())
    @IsString()
    @MinLength(6)
    @IsNotEmpty()
    password: string;
    
    
    
    
}
