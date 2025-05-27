# Servicio de Productos - AWS Serverless

Este proyecto implementa un servicio de productos utilizando una arquitectura serverless en AWS. Permite crear y consultar productos a través de una API REST protegida con autenticación JWT.

## Tecnologías utilizadas

- **AWS Lambda**: Funciones serverless para ejecutar código bajo demanda
- **Amazon DynamoDB**: Base de datos NoSQL para almacenar los productos
- **Amazon API Gateway**: Puerta de entrada para APIs REST
- **Terraform**: Infraestructura como código para provisionar recursos de AWS
- **TypeScript**: Lenguaje de programación con tipado estático
- **esbuild**: Empaquetador y minificador rápido para JavaScript/TypeScript

## Estructura del proyecto

```
market-aws-lambda-products/
├── src/
│   ├── domain/
│   │   └── entity/
│   │       └── products.entity.interface.ts
│   └── infrastructure/
│       └── handlers/
│           ├── create-products/
│           │   └── index.ts
│           └── get-products/
│               └── index.ts
├── terraform/
│   ├── modules/
│   │   ├── api-gateway/
│   │   ├── dynamo-db/
│   │   ├── lambda/
│   │   └── shared-resources/
│   ├── api-gateway.tf
│   ├── api-gateway-authorizer.tf
│   ├── dynamo-db.tf
│   ├── lambdas.tf
│   ├── provider.tf
│   └── variables.tf
├── build.js
├── package.json
└── .gitignore
```

## Funcionalidades

### API de Productos

1. **Crear producto (POST /products)**

   - Crea un nuevo producto en la base de datos
   - Requiere autenticación JWT
   - Cada producto contiene: id, nombre, marca, categorías, precio, usuario y fecha de creación

2. **Obtener productos (GET /products)**
   - Recupera todos los productos almacenados
   - Requiere autenticación JWT

## Infraestructura como código (Terraform)

El proyecto utiliza Terraform para definir y aprovisionar toda la infraestructura necesaria en AWS:

### Módulos principales

- **api-gateway**: Configura el API Gateway HTTP para exponer las funciones Lambda
- **dynamo-db**: Define la tabla de productos con índices secundarios globales
- **lambda**: Configura las funciones Lambda y sus integraciones con API Gateway
- **shared-resources**: Define roles y políticas IAM compartidas entre funciones

### Seguridad

- Implementa un autorizador JWT personalizado para proteger los endpoints de la API
- Roles IAM con permisos mínimos necesarios para cada servicio

## Desarrollo y despliegue

### Requisitos previos

- Node.js y npm
- AWS CLI configurado con credenciales
- Terraform CLI

### Comandos disponibles

- **Construir lambdas**: `npm run build:lambdas`

  - Compila el código TypeScript utilizando esbuild
  - Genera archivos ZIP para cada función Lambda

- **Desplegar infraestructura**: `npm run deploy`
  - Construye las funciones Lambda
  - Ejecuta terraform apply para desplegar todos los recursos en AWS

### Variables de entorno

El proyecto requiere las siguientes variables para el despliegue:

- `aws_region`: Región de AWS donde se despliegan los recursos
- `aws_access_key`: Clave de acceso para AWS
- `aws_secret_key`: Clave secreta para AWS
- `jwt_secret`: Clave secreta para validar tokens JWT

## Modelo de datos

### Producto (Product)

```typescript
interface IProduct {
  id: string; // Identificador único del producto
  name: string; // Nombre del producto
  brand: string; // Marca del producto
  categories: string[]; // Categorías a las que pertenece
  price: number; // Precio del producto
  userId: string; // ID del usuario que creó el producto
  createdAt: string; // Fecha de creación
}
```

## Contribución

1. Hacer fork del repositorio
2. Crear una rama para la nueva funcionalidad
3. Implementar cambios
4. Enviar un Pull Request
