import { Game } from '../gamr/Game';

@Entry
@Component
struct Index {
  private game: Game = new Game();
  @State grid: number[][] = this.game.getGrid();
  @State score: number = this.game.getScore();
  @State bestScore: number = this.game.getBestScore();
  @State gameOver: boolean = this.game.isGameOver();
  @State gameWon: boolean = this.game.isGameWon();

  private updateGameState(): void {
    this.grid = this.game.getGrid();
    this.score = this.game.getScore();
    this.bestScore = this.game.getBestScore();
    this.gameOver = this.game.isGameOver();
    this.gameWon = this.game.isGameWon();
  }

  private restartGame(): void {
    this.game.restart();
    this.updateGameState();
  }

  private moveLeft(): void {
    const moved = this.game.moveLeft();
    if (moved) {
      this.updateGameState();
    }
  }

  private moveUp(): void {
    const moved = this.game.moveUp();
    if (moved) {
      this.updateGameState();
    }
  }

  private moveRight(): void {
    const moved = this.game.moveRight();
    if (moved) {
      this.updateGameState();
    }
  }

  private moveDown(): void {
    const moved = this.game.moveDown();
    if (moved) {
      this.updateGameState();
    }
  }

  private getTileColor(value: number): string {
    switch (value) {
      case 0: return '#cdc1b4';
      case 2: return '#eee4da';
      case 4: return '#ede0c8';
      case 8: return '#f2b179';
      case 16: return '#f59563';
      case 32: return '#f67c5f';
      case 64: return '#f65e3b';
      case 128: return '#edcf72';
      case 256: return '#edcc61';
      case 512: return '#edc850';
      case 1024: return '#edc53f';
      case 2048: return '#edc22e';
      default: return '#3c3a32';
    }
  }

  private getTextColor(value: number): string {
    return value <= 4 ? '#776e65' : '#f9f6f2';
  }

  build() {
    Column() {
      Row() {
        Text('2048')
          .fontSize(36)
          .fontWeight(FontWeight.Bold)
          .fontColor('#776e65')
          .margin({ left: 20, top: 20 })

        Column() {
          Row() {
            Text('分数')
              .fontSize(14)
              .fontColor('#eee4da')
              .margin({ right: 10 })
            Text(this.score.toString())
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor('#ffffff')
          }
          .backgroundColor('#bbada0')
          .padding({ left: 15, right: 15, top: 5, bottom: 5 })
          .borderRadius(3)
          .margin({ right: 10 })

          Row() {
            Text('最高分')
              .fontSize(14)
              .fontColor('#eee4da')
              .margin({ right: 10 })
            Text(this.bestScore.toString())
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor('#ffffff')
          }
          .backgroundColor('#bbada0')
          .padding({ left: 15, right: 15, top: 5, bottom: 5 })
          .borderRadius(3)
        }
        .margin({ right: 20, top: 20 })
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width('100%')

      Row() {
        Text('点击方向按钮移动方块')
          .fontSize(14)
          .fontColor('#776e65')
          .margin({ left: 20, top: 10 })
        Button('重新开始')
          .fontSize(14)
          .fontColor('#ffffff')
          .backgroundColor('#8f7a66')
          .padding({ left: 10, right: 10, top: 5, bottom: 5 })
          .borderRadius(3)
          .margin({ right: 20, top: 10 })
          .onClick(() => {
            this.restartGame();
          })
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width('100%')

      Stack() {
        Grid() {
          ForEach(this.grid, (row: number[]) => {
            ForEach(row, (value: number) => {
              GridItem() {
                Stack() {
                  Text(value === 0 ? '' : value.toString())
                    .fontSize(value < 100 ? 24 : value < 1000 ? 20 : 16)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(this.getTextColor(value))
                }
                .width('100%')
                .height('100%')
                .backgroundColor(this.getTileColor(value))
                .borderRadius(3)
              }
            })
          })
        }
        .rowsTemplate('1fr 1fr 1fr 1fr')
        .columnsTemplate('1fr 1fr 1fr 1fr')
        .rowsGap(10)
        .columnsGap(10)
        .width('90%')
        .height('60%')
        .backgroundColor('#bbada0')
        .padding(10)
        .borderRadius(6)
        .margin({ top: 20 })

        if (this.gameWon) {
          Stack() {
            Text('你赢了！')
              .fontSize(36)
              .fontWeight(FontWeight.Bold)
              .fontColor('#776e65')
              .align(Alignment.Center)
            Button('继续游戏')
              .fontSize(16)
              .fontColor('#ffffff')
              .backgroundColor('#8f7a66')
              .padding({ left: 20, right: 20, top: 10, bottom: 10 })
              .borderRadius(3)
              .margin({ top: 60 })
              .onClick(() => {
                this.gameWon = false;
              })
            Button('重新开始')
              .fontSize(16)
              .fontColor('#ffffff')
              .backgroundColor('#8f7a66')
              .padding({ left: 20, right: 20, top: 10, bottom: 10 })
              .borderRadius(3)
              .margin({ top: 110 })
              .onClick(() => {
                this.restartGame();
              })
          }
          .width('100%')
          .height('100%')
          .backgroundColor('rgba(255, 255, 255, 0.8)')
          .borderRadius(6)
        }

        if (this.gameOver) {
          Stack() {
            Text('游戏结束！')
              .fontSize(36)
              .fontWeight(FontWeight.Bold)
              .fontColor('#776e65')
              .align(Alignment.Center)
            Button('重新开始')
              .fontSize(16)
              .fontColor('#ffffff')
              .backgroundColor('#8f7a66')
              .padding({ left: 20, right: 20, top: 10, bottom: 10 })
              .borderRadius(3)
              .margin({ top: 60 })
              .onClick(() => {
                this.restartGame();
              })
          }
          .width('100%')
          .height('100%')
          .backgroundColor('rgba(255, 255, 255, 0.8)')
          .borderRadius(6)
        }
      }

      Row() {
        Button('上')
          .fontSize(16)
          .fontColor('#ffffff')
          .backgroundColor('#8f7a66')
          .padding({ left: 30, right: 30, top: 15, bottom: 15 })
          .margin({ top: 20 })
          .onClick(() => {
            this.moveUp();
          })
      }
      .justifyContent(FlexAlign.Center)

      Row() {
        Button('左')
          .fontSize(16)
          .fontColor('#ffffff')
          .backgroundColor('#8f7a66')
          .padding({ left: 30, right: 30, top: 15, bottom: 15 })
          .margin({ top: 10, right: 20 })
          .onClick(() => {
            this.moveLeft();
          })

        Button('右')
          .fontSize(16)
          .fontColor('#ffffff')
          .backgroundColor('#8f7a66')
          .padding({ left: 30, right: 30, top: 15, bottom: 15 })
          .margin({ top: 10, left: 20 })
          .onClick(() => {
            this.moveRight();
          })
      }
      .justifyContent(FlexAlign.Center)

      Row() {
        Button('下')
          .fontSize(16)
          .fontColor('#ffffff')
          .backgroundColor('#8f7a66')
          .padding({ left: 30, right: 30, top: 15, bottom: 15 })
          .margin({ top: 10, bottom: 20 })
          .onClick(() => {
            this.moveDown();
          })
      }
      .justifyContent(FlexAlign.Center)

      Text('如何玩：移动方块，相同数字的方块会合并成为它们的和。尝试得到2048方块！')
        .fontSize(14)
        .fontColor('#776e65')
        .margin({ left: 20, right: 20, bottom: 20 })
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#faf8ef')
  }
}