import { Injectable, UnauthorizedException } from '@nestjs/common';
import {  SignUpDto } from './dto/signUp.dto';
import { UserService } from 'src/user/user.service';
import * as bcryptjs from 'bcryptjs';
import { SignInDto } from './dto/signIn.dto';
import { JwtService } from '@nestjs/jwt';

@Injectable()
export class AuthService {
  constructor(
    private readonly userService: UserService,
    private readonly jwtService: JwtService
  ) {}


  async signUp({name, email, password}: SignUpDto) {
    const emailExists = await this.userService.findByEmail(email);
    if(emailExists) {
      throw new UnauthorizedException('Email already exists');
    }
    return await this.userService.create({
      name,
      email, 
      password: await bcryptjs.hash(password, 10)
    });
  }

  async signIn({email, password}: SignInDto) {
    const user = await this.userService.findByEmail(email);
    if(!user) {
      throw new UnauthorizedException('Invalid credentials');
    }
    const validPassword = await bcryptjs.compare(password, user.contrasena);
    if(!validPassword) {
      throw new UnauthorizedException('Invalid credentials');
    }

    const payload = { email: user.email, sub: user.id_usuario };

    const token = this.jwtService.sign(payload);
    return token;
  }
}
 