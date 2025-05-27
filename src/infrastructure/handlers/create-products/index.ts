import { APIGatewayProxyEvent, APIGatewayProxyResult } from 'aws-lambda';

export const handler = async (
  event: APIGatewayProxyEvent
): Promise<APIGatewayProxyResult> => {
  console.log(`event: ${JSON.stringify(event)}`);

  try {
    // Acceder al ID del usuario del contexto
    const userId = event.requestContext.authorizer?.lambda?.userId;
    if (!userId) {
      throw new Error("No se pudo obtener el userId del contexto de autorización.");
    }

    // Usar el ID del usuario para operaciones específicas
    console.log(`Usuario autenticado con ID: ${userId}`);

    return {
      statusCode: 200,
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify({
        message: "Acceso exitoso a recurso protegido",
        userId: userId
      })
    };
  } catch (error) {
    console.log('Error:', error);
    return {
      statusCode: 500,
      body: JSON.stringify({ message: "Error interno del servidor" })
    };
  }
};