import { APIGatewayProxyEvent, APIGatewayProxyResult } from "aws-lambda";
import { DynamoDB } from "aws-sdk";
import { v4 as uuidv4 } from "uuid";
import { IProduct } from "../../../domain/entity/products.entity.interface";

const dynamoDB = new DynamoDB.DocumentClient();
const TABLE_NAME = process.env.PRODUCTS_TABLE || "products";

export const handler = async (
  event: APIGatewayProxyEvent
): Promise<APIGatewayProxyResult> => {
  console.log(`event: ${JSON.stringify(event)}`);

  try {

    const userId = event.requestContext.authorizer?.lambda?.userId;
    if (!userId) {
      throw new Error(
        "No se pudo obtener el userId del contexto de autorización."
      );
    }

 
    if (!event.body) {
      return {
        statusCode: 400,
        body: JSON.stringify({
          message: "El cuerpo de la solicitud no puede estar vacío",
        }),
      };
    }

    const productData = JSON.parse(event.body);


    if (
      !productData.name ||
      !productData.brand ||
      !productData.price ||
      !Array.isArray(productData.categories)
    ) {
      return {
        statusCode: 400,
        body: JSON.stringify({
          message: "Faltan campos requeridos: name, brand, categories, price",
        }),
      };
    }


    const newProduct: IProduct = {
      id: uuidv4(),
      name: productData.name,
      brand: productData.brand,
      categories: productData.categories,
      price: productData.price,
      userId: userId,
      createdAt: new Date().toISOString(),
    };


    await dynamoDB
      .put({
        TableName: TABLE_NAME,
        Item: newProduct,
      })
      .promise();

    return {
      statusCode: 201,
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        message: "Producto registrado exitosamente",
        data: newProduct,
      }),
    };
  } catch (error) {
    console.log("Error:", error);
    return {
      statusCode: 500,
      body: JSON.stringify({ message: "Error interno del servidor" }),
    };
  }
};
