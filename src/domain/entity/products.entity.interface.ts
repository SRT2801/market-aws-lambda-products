export interface IProduct {
  id: string;
  name: string;
  price: number;
  description: string;
  category: string;
  stock: number;
  imageUrl?: string;
  createdAt: string;
}
