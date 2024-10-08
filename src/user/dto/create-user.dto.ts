import { Transform } from 'class-transformer';
import { IsString, IsEmail, IsNotEmpty, MinLength } from 'class-validator';

export class CreateUserDto {

    @Transform(({ value }) => value.trim())
    @IsString()
    @IsNotEmpty()
    name: string;
    
    @IsEmail()
    email: string;
    
    @Transform(({ value }) => value.trim())
    @IsString()
    @IsNotEmpty()
    @MinLength(8)
    password: string;
}
