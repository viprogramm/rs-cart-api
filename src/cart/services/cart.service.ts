import { Inject, Injectable } from '@nestjs/common';

import { v4 } from 'uuid';

import { Cart } from '../models';
import { PG_CONNECTION } from 'src/constants';

@Injectable()
export class CartService {
  // private userCarts: Record<string, Cart> = {};
  private userCarts: Record<string, Cart> = { 1: { id: 'id', items: [] } };

  constructor(@Inject(PG_CONNECTION) private conn: any) {}

  findByUserId(userId: string): Cart {
    return this.userCarts[userId];
  }

  createByUserId(userId: string) {
    const id = v4(v4());
    const userCart = {
      id,
      items: [],
    };

    this.userCarts[userId] = userCart;

    return userCart;
  }

  async findOrCreateByUserId(userId: string): Promise<Cart> {
    try {
      const userCart = await this.conn.query('select * from carts');

      if (userCart) {
        return userCart;
      }

      return this.createByUserId(userId);
    } catch (error) {
      console.log('!EROROR', error);
    }
  }

  async updateByUserId(userId: string, { items }: Cart): Promise<Cart> {
    const { id, ...rest } = await this.findOrCreateByUserId(userId);

    const updatedCart = {
      id,
      ...rest,
      items: [...items],
    };

    this.userCarts[userId] = { ...updatedCart };

    return { ...updatedCart };
  }

  removeByUserId(userId): void {
    this.userCarts[userId] = null;
  }
}
