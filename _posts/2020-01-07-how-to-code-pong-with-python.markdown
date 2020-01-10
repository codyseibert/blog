---
layout: post
title: 'How to code a game with python'
date: 2020-01-07 23:51:58 -0500
categories: python games tutorial
---

## Prerequisites

python3 is installed

pip is installed

## Step 1: Install venv & pygame

`mkdir python-pygame-pong`

`python3 -m venv .`

`pip install pygame==2.0.0.dev6`

## Step 2: Drawing a Red Circle in Pygame

```
import pygame
from pygame.locals import *

SCREEN_WIDTH = 640
SCREEN_HEIGHT = 480

WHITE = (255, 255, 255)
RED = (255, 0, 0)

pygame.init()
screen = pygame.display.set_mode((SCREEN_WIDTH, SCREEN_HEIGHT))
pygame.display.set_caption("Python PONG")

clock = pygame.time.Clock()

done = False


def draw():
    screen.fill(WHITE)
    pygame.draw.circle(screen, RED, (SCREEN_WIDTH // 2, SCREEN_HEIGHT // 2), 10)
    pygame.display.flip()


def update():
    global done
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            done = True


while not done:
    clock.tick(30)
    update()
    draw()

pygame.quit()
```

## Step 3: Making a Ball Class

```
# ball.py
import pygame
from constants import *


class Ball:
    def __init__(self):
        self.vx = 5
        self.vy = 5
        self.x = SCREEN_WIDTH // 2
        self.y = SCREEN_HEIGHT // 2
        self.radius = 10

    def get_rect(self):
        return pygame.Rect(
            self.x - self.radius, self.y - self.radius, self.radius * 2, self.radius * 2
        )

    def move(self):
        self.x += self.vx
        self.y += self.vy

    def handle_collisions(self, is_game_over):
        if self.x > SCREEN_WIDTH - self.radius // 2 or self.x < self.radius // 2:
            self.vx *= -1

        if self.y > SCREEN_HEIGHT - self.radius // 2 or self.y < self.radius // 2:
            self.vy *= -1

    def update(self, is_game_over):
        self.move()
        self.handle_collisions(is_game_over)

    def draw(self, screen):
        pygame.draw.circle(screen, RED, (self.x, self.y), self.radius)

```

```
# main.py
import pygame
from pygame.locals import *
from constants import *

from ball import Ball

pygame.init()
screen = pygame.display.set_mode((SCREEN_WIDTH, SCREEN_HEIGHT))
pygame.display.set_caption("Python PONG")

clock = pygame.time.Clock()

done = False

ball = None


def setup_game():
    global ball
    ball = Ball()


def draw():
    screen.fill(WHITE)
    ball.draw(screen)
    pygame.display.flip()


def update():
    global done
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            done = True

    ball.update([done])


setup_game()

while not done:
    clock.tick(30)
    update()
    draw()

pygame.quit()

```

## Step 4: Making the Paddle Class

```
# paddle.py
import pygame
from constants import *

BLUE = (0, 0, 255)

class Paddle:
    MOVE_SPEED = 5

    def __init__(self):
        self.rect = pygame.Rect(0, SCREEN_HEIGHT // 2, 20, 100)

    def move_up(self):
        self.rect.y -= self.MOVE_SPEED
        self._keep_in_bounds()

    def move_down(self):
        self.rect.y += self.MOVE_SPEED
        self._keep_in_bounds()

    def _keep_in_bounds(self):
        self.rect.y = max(self.rect.y, 0)
        self.rect.y = min(self.rect.y, SCREEN_HEIGHT - self.rect.height)

    def draw(self, screen):
        pygame.draw.rect(
            screen, BLUE, self.rect,
        )
```

```
# main.py
import pygame
from pygame.locals import *
from constants import *

from ball import Ball
from paddle import Paddle

pygame.init()
screen = pygame.display.set_mode((SCREEN_WIDTH, SCREEN_HEIGHT))
pygame.display.set_caption("Python PONG")

clock = pygame.time.Clock()

done = False

ball = None
left_paddle = None
right_paddle = None


def setup_game():
    global ball
    global left_paddle
    global right_paddle
    ball = Ball()
    left_paddle = Paddle()
    right_paddle = Paddle()
    right_paddle.rect.x = SCREEN_WIDTH - right_paddle.rect.width


def draw():
    screen.fill(WHITE)
    ball.draw(screen)
    left_paddle.draw(screen)
    right_paddle.draw(screen)
    pygame.display.flip()


def update():
    global done
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            done = True

    ball.update([done])


setup_game()

while not done:
    clock.tick(30)
    update()
    draw()

pygame.quit()
```

## Step 5: Moving the Paddles with Keyboard Input

```
# inputs.py

import pygame
from pygame.locals import *


def handle_events(done):
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            done[0] = True


def handle_input(left_paddle, right_paddle):
    pygame.event.pump()
    keys = pygame.key.get_pressed()

    if keys[K_w]:
        left_paddle.move_up()
    elif keys[K_s]:
        left_paddle.move_down()

    if keys[K_UP]:
        right_paddle.move_up()
    elif keys[K_DOWN]:
        right_paddle.move_down()

    if keys[K_ESCAPE]:
        done[0] = True

```

```
# main.py
import pygame
from pygame.locals import *
from constants import *

from ball import Ball
from paddle import Paddle
from inputs import handle_events, handle_input

pygame.init()
screen = pygame.display.set_mode((SCREEN_WIDTH, SCREEN_HEIGHT))
pygame.display.set_caption("Python PONG")

clock = pygame.time.Clock()

done = False

ball = None
left_paddle = None
right_paddle = None


def setup_game():
    global ball
    global left_paddle
    global right_paddle
    ball = Ball()
    left_paddle = Paddle()
    right_paddle = Paddle()
    right_paddle.rect.x = SCREEN_WIDTH - right_paddle.rect.width


def draw():
    screen.fill(WHITE)
    ball.draw(screen)
    left_paddle.draw(screen)
    right_paddle.draw(screen)
    pygame.display.flip()


def update():
    handle_events([done])
    handle_input(left_paddle, right_paddle)
    ball.update([done])


setup_game()

while not done:
    clock.tick(30)
    update()
    draw()

pygame.quit()
```

## Step 6: Making the Ball Bounce off the Paddles and Ending the Game
```
# main.py
import pygame
from pygame.locals import *
from constants import *

from ball import Ball
from paddle import Paddle
from inputs import handle_events, handle_input

pygame.init()
screen = pygame.display.set_mode((SCREEN_WIDTH, SCREEN_HEIGHT))
pygame.display.set_caption("Python PONG")

clock = pygame.time.Clock()

done = [False]
is_game_over = [False]

ball = None
left_paddle = None
right_paddle = None


def setup_game():
    global ball
    global left_paddle
    global right_paddle
    ball = Ball()
    left_paddle = Paddle()
    right_paddle = Paddle()
    right_paddle.rect.x = SCREEN_WIDTH - right_paddle.rect.width


def draw_game_over():
    font = pygame.font.Font("freesansbold.ttf", 32)
    game_over = font.render("GAME OVER", True, RED)
    game_over_rect = game_over.get_rect()
    game_over_rect.center = (SCREEN_WIDTH // 2, SCREEN_HEIGHT // 2)
    screen.blit(game_over, game_over_rect)


def draw_game():
    left_paddle.draw(screen)
    right_paddle.draw(screen)
    ball.draw(screen)


def draw():
    screen.fill(WHITE)

    if is_game_over[0]:
        draw_game_over()
    else:
        draw_game()

    pygame.display.flip()


def update():
    handle_events(done)
    if not is_game_over[0]:
        handle_input(left_paddle, right_paddle)
        ball.update(left_paddle, right_paddle, is_game_over)


setup_game()

while not done[0]:
    clock.tick(30)
    update()
    draw()

pygame.quit()

```

```
import pygame
from constants import *


class Ball:
    def __init__(self):
        self.vx = 5
        self.vy = 5
        self.x = SCREEN_WIDTH // 2
        self.y = SCREEN_HEIGHT // 2
        self.radius = 10

    def get_rect(self):
        return pygame.Rect(
            self.x - self.radius, self.y - self.radius, self.radius * 2, self.radius * 2
        )

    def move(self):
        self.x += self.vx
        self.y += self.vy

    def handle_collisions(self, left_paddle, right_paddle, is_game_over):
        if self.x > SCREEN_WIDTH - self.radius // 2 or self.x < self.radius // 2:
            is_game_over[0] = True

        if self.y > SCREEN_HEIGHT - self.radius // 2 or self.y < self.radius // 2:
            self.vy *= -1

        if self.get_rect().colliderect(left_paddle.rect) or self.get_rect().colliderect(
            right_paddle.rect
        ):
            self.vx *= -1

    def update(self, left_paddle, right_paddle, is_game_over):
        self.move()
        self.handle_collisions(left_paddle, right_paddle, is_game_over)

    def draw(self, screen):
        pygame.draw.circle(screen, RED, (self.x, self.y), self.radius)
```