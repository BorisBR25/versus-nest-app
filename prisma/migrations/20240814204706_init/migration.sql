-- CreateEnum
CREATE TYPE "Rol" AS ENUM ('ADMIN', 'USER');

-- CreateEnum
CREATE TYPE "EstadoMatch" AS ENUM ('PENDING', 'IN_PROGRESS', 'FINISHED');

-- CreateEnum
CREATE TYPE "EstadoApuesta" AS ENUM ('PENDING', 'WIN', 'LOSS', 'CANCELED');

-- CreateEnum
CREATE TYPE "TipoDeporte" AS ENUM ('SOCCER', 'BASKETBALL', 'TENNIS', 'BASEBALL', 'VOLLEYBALL');

-- CreateEnum
CREATE TYPE "CategoriaEdad" AS ENUM ('UNDER_18', 'UNDER_21', 'ADULT', 'SENIOR');

-- CreateEnum
CREATE TYPE "CategoriaGenero" AS ENUM ('MALE', 'FEMALE', 'OTHER');

-- CreateTable
CREATE TABLE "Usuario" (
    "id_usuario" SERIAL NOT NULL,
    "nombre_usuario" VARCHAR(255) NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "contrasena" VARCHAR(255) NOT NULL,
    "fecha_registro" DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "genero" VARCHAR(50),
    "edad" INTEGER,
    "ubicacion" VARCHAR(255),
    "tipo_usuario" VARCHAR(50),

    CONSTRAINT "Usuario_pkey" PRIMARY KEY ("id_usuario")
);

-- CreateTable
CREATE TABLE "Deporte" (
    "id_deporte" SERIAL NOT NULL,
    "nombre_deporte" VARCHAR(255) NOT NULL,
    "tipo_deporte" VARCHAR(50) NOT NULL,

    CONSTRAINT "Deporte_pkey" PRIMARY KEY ("id_deporte")
);

-- CreateTable
CREATE TABLE "Equipo" (
    "id_equipo" SERIAL NOT NULL,
    "nombre_equipo" VARCHAR(255) NOT NULL,
    "id_deporte" INTEGER NOT NULL,
    "id_capitan" INTEGER NOT NULL,
    "categoria_edad" VARCHAR(50),
    "categoria_genero" VARCHAR(50),
    "fecha_creacion" DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Equipo_pkey" PRIMARY KEY ("id_equipo")
);

-- CreateTable
CREATE TABLE "Equipo_Jugadores" (
    "id_equipo" INTEGER NOT NULL,
    "id_usuario" INTEGER NOT NULL,
    "fecha_union" DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "rol" VARCHAR(50),

    CONSTRAINT "Equipo_Jugadores_pkey" PRIMARY KEY ("id_equipo","id_usuario")
);

-- CreateTable
CREATE TABLE "Match" (
    "id_match" SERIAL NOT NULL,
    "id_equipo_1" INTEGER NOT NULL,
    "id_equipo_2" INTEGER NOT NULL,
    "id_deporte" INTEGER NOT NULL,
    "fecha_match" DATE,
    "ubicacion" VARCHAR(255),
    "monto_apuesta" DOUBLE PRECISION,
    "resultado_equipo_1" INTEGER,
    "resultado_equipo_2" INTEGER,
    "estado_match" VARCHAR(50),

    CONSTRAINT "Match_pkey" PRIMARY KEY ("id_match")
);

-- CreateTable
CREATE TABLE "Apuesta" (
    "id_apuesta" SERIAL NOT NULL,
    "id_match" INTEGER NOT NULL,
    "id_usuario" INTEGER NOT NULL,
    "monto_apostado" DOUBLE PRECISION NOT NULL,
    "equipo_apostado" INTEGER NOT NULL,
    "fecha_apuesta" DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "estado_apuesta" VARCHAR(50),

    CONSTRAINT "Apuesta_pkey" PRIMARY KEY ("id_apuesta")
);

-- CreateTable
CREATE TABLE "Resultado" (
    "id_resultado" SERIAL NOT NULL,
    "id_deporte" INTEGER NOT NULL,
    "id_equipo_1" INTEGER NOT NULL,
    "id_equipo_2" INTEGER NOT NULL,
    "resultado_equipo_1" INTEGER,
    "resultado_equipo_2" INTEGER,
    "fecha_resultado" DATE,

    CONSTRAINT "Resultado_pkey" PRIMARY KEY ("id_resultado")
);

-- CreateTable
CREATE TABLE "Plataforma_Apuestas" (
    "id_plataforma" SERIAL NOT NULL,
    "nombre_plataforma" VARCHAR(255) NOT NULL,
    "url_plataforma" VARCHAR(255),
    "contacto" VARCHAR(255),

    CONSTRAINT "Plataforma_Apuestas_pkey" PRIMARY KEY ("id_plataforma")
);

-- CreateTable
CREATE TABLE "Equipos_Plataformas" (
    "id_equipo" INTEGER NOT NULL,
    "id_plataforma" INTEGER NOT NULL,
    "fecha_vinculacion" DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Equipos_Plataformas_pkey" PRIMARY KEY ("id_equipo","id_plataforma")
);

-- CreateIndex
CREATE UNIQUE INDEX "Usuario_email_key" ON "Usuario"("email");

-- AddForeignKey
ALTER TABLE "Equipo" ADD CONSTRAINT "Equipo_id_capitan_fkey" FOREIGN KEY ("id_capitan") REFERENCES "Usuario"("id_usuario") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Equipo" ADD CONSTRAINT "Equipo_id_deporte_fkey" FOREIGN KEY ("id_deporte") REFERENCES "Deporte"("id_deporte") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Equipo_Jugadores" ADD CONSTRAINT "Equipo_Jugadores_id_equipo_fkey" FOREIGN KEY ("id_equipo") REFERENCES "Equipo"("id_equipo") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Equipo_Jugadores" ADD CONSTRAINT "Equipo_Jugadores_id_usuario_fkey" FOREIGN KEY ("id_usuario") REFERENCES "Usuario"("id_usuario") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Match" ADD CONSTRAINT "Match_id_equipo_1_fkey" FOREIGN KEY ("id_equipo_1") REFERENCES "Equipo"("id_equipo") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Match" ADD CONSTRAINT "Match_id_equipo_2_fkey" FOREIGN KEY ("id_equipo_2") REFERENCES "Equipo"("id_equipo") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Match" ADD CONSTRAINT "Match_id_deporte_fkey" FOREIGN KEY ("id_deporte") REFERENCES "Deporte"("id_deporte") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Apuesta" ADD CONSTRAINT "Apuesta_id_match_fkey" FOREIGN KEY ("id_match") REFERENCES "Match"("id_match") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Apuesta" ADD CONSTRAINT "Apuesta_id_usuario_fkey" FOREIGN KEY ("id_usuario") REFERENCES "Usuario"("id_usuario") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Apuesta" ADD CONSTRAINT "Apuesta_equipo_apostado_fkey" FOREIGN KEY ("equipo_apostado") REFERENCES "Equipo"("id_equipo") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Resultado" ADD CONSTRAINT "Resultado_id_equipo_1_fkey" FOREIGN KEY ("id_equipo_1") REFERENCES "Equipo"("id_equipo") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Resultado" ADD CONSTRAINT "Resultado_id_equipo_2_fkey" FOREIGN KEY ("id_equipo_2") REFERENCES "Equipo"("id_equipo") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Resultado" ADD CONSTRAINT "Resultado_id_deporte_fkey" FOREIGN KEY ("id_deporte") REFERENCES "Deporte"("id_deporte") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Equipos_Plataformas" ADD CONSTRAINT "Equipos_Plataformas_id_equipo_fkey" FOREIGN KEY ("id_equipo") REFERENCES "Equipo"("id_equipo") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Equipos_Plataformas" ADD CONSTRAINT "Equipos_Plataformas_id_plataforma_fkey" FOREIGN KEY ("id_plataforma") REFERENCES "Plataforma_Apuestas"("id_plataforma") ON DELETE RESTRICT ON UPDATE CASCADE;
