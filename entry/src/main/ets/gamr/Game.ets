export class Game {
  private grid: number[][];
  private score: number;
  private bestScore: number;
  private gameOver: boolean;
  private gameWon: boolean;

  constructor() {
    this.grid = Array(4).fill(0).map(() => Array(4).fill(0));
    this.score = 0;
    this.bestScore = 0;
    this.gameOver = false;
    this.gameWon = false;
    this.initGame();
  }

  private initGame(): void {
    this.grid = Array(4).fill(0).map(() => Array(4).fill(0));
    this.score = 0;
    this.gameOver = false;
    this.gameWon = false;
    this.addRandomTile();
    this.addRandomTile();
  }

  private addRandomTile(): void {
    const emptyCells: Array<[number, number]> = [];
    for (let i = 0; i < 4; i++) {
      for (let j = 0; j < 4; j++) {
        if (this.grid[i][j] === 0) {
          emptyCells.push([i, j]);
        }
      }
    }

    if (emptyCells.length > 0) {
      const randomIndex = Math.floor(Math.random() * emptyCells.length);
      const row = emptyCells[randomIndex][0];
      const col = emptyCells[randomIndex][1];
      this.grid[row][col] = Math.random() < 0.9 ? 2 : 4;
    }
  }

  private compressGrid(): boolean {
    let changed = false;
    const newGrid: number[][] = Array(4).fill(0).map(() => Array(4).fill(0));

    for (let i = 0; i < 4; i++) {
      let pos = 0;
      for (let j = 0; j < 4; j++) {
        if (this.grid[i][j] !== 0) {
          newGrid[i][pos] = this.grid[i][j];
          if (pos !== j) {
            changed = true;
          }
          pos++;
        }
      }
    }

    this.grid = newGrid;
    return changed;
  }

  private mergeGrid(): boolean {
    let changed = false;

    for (let i = 0; i < 4; i++) {
      for (let j = 0; j < 3; j++) {
        if (this.grid[i][j] !== 0 && this.grid[i][j] === this.grid[i][j + 1]) {
          this.grid[i][j] *= 2;
          this.score += this.grid[i][j];
          if (this.score > this.bestScore) {
            this.bestScore = this.score;
          }
          this.grid[i][j + 1] = 0;
          changed = true;
          if (this.grid[i][j] === 2048) {
            this.gameWon = true;
          }
        }
      }
    }

    return changed;
  }

  private reverseGrid(): void {
    for (let i = 0; i < 4; i++) {
      this.grid[i].reverse();
    }
  }

  private transposeGrid(): void {
    const newGrid: number[][] = Array(4).fill(0).map(() => Array(4).fill(0));
    for (let i = 0; i < 4; i++) {
      for (let j = 0; j < 4; j++) {
        newGrid[j][i] = this.grid[i][j];
      }
    }
    this.grid = newGrid;
  }

  public moveLeft(): boolean {
    const compressed = this.compressGrid();
    const merged = this.mergeGrid();
    const compressedAgain = this.compressGrid();
    const moved = compressed || merged || compressedAgain;

    if (moved) {
      this.addRandomTile();
      this.checkGameOver();
    }

    return moved;
  }

  public moveRight(): boolean {
    this.reverseGrid();
    const moved = this.moveLeft();
    this.reverseGrid();
    return moved;
  }

  public moveUp(): boolean {
    this.transposeGrid();
    const moved = this.moveLeft();
    this.transposeGrid();
    return moved;
  }

  public moveDown(): boolean {
    this.transposeGrid();
    this.reverseGrid();
    const moved = this.moveLeft();
    this.reverseGrid();
    this.transposeGrid();
    return moved;
  }

  private checkGameOver(): void {
    for (let i = 0; i < 4; i++) {
      for (let j = 0; j < 4; j++) {
        if (this.grid[i][j] === 0) {
          return;
        }
        if (j < 3 && this.grid[i][j] === this.grid[i][j + 1]) {
          return;
        }
        if (i < 3 && this.grid[i][j] === this.grid[i + 1][j]) {
          return;
        }
      }
    }
    this.gameOver = true;
  }

  public getGrid(): number[][] {
    return this.grid;
  }

  public getScore(): number {
    return this.score;
  }

  public getBestScore(): number {
    return this.bestScore;
  }

  public isGameOver(): boolean {
    return this.gameOver;
  }

  public isGameWon(): boolean {
    return this.gameWon;
  }

  public restart(): void {
    this.initGame();
  }
}