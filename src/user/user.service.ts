import { Injectable } from '@nestjs/common';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import { PrismaClient } from '@prisma/client';

@Injectable()
export class UserService {

private prisma = new PrismaClient();




  async create(user: CreateUserDto) {

    
    
    return await this.prisma.usuario.create({
      data: {
        nombre_usuario: user.name,
        email: user.email,
        contrasena: user.password,
        }
      });
      
  }

  async findByEmail(email: string) {
    return await this.prisma.usuario.findUnique({
      where: {
        email: email,
      },
    });
  }

  findAll() {
    return this.prisma.usuario.findMany();
  }

  findOne(id: number) {
    return `This action returns a #${id} user`;
  }

  update(id: number, updateUserDto: UpdateUserDto) {
    return `This action updates a #${id} user`;
  }

  remove(id: number) {
    return `This action removes a #${id} user`;
  }
}
