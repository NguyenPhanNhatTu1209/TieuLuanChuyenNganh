
export enum ApiMethods {
  GET = "GET",
  POST = "POST",
  PUT = "PUT",
  DELETE = "DELETE",
}

export interface ApiRoutes{
  method:ApiMethods,
  url:string
}