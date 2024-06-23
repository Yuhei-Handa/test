# [WIP]ec2 インスタンス ssh 利用のためのセットアップ方法

1. AWS CLI2 のインストール
   [こちら](https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/install-cliv2.html)の手順に沿ってインストールを行う。

2. 鍵無しでの認証の準備
   https://github.com/moajo/ssh_ec2/ を導入する

3. インスタンスの作成
   main.tf に定義例があるので uncomment する

# インスタンスの停止/再開

```sh
aws ec2 stop-instances --instance-ids ${インスタンスID} # 停止
aws ec2 start-instances --instance-ids ${インスタンスID} # 再開
```

# [管理社員向け] terraform のセットアップ

1. インストール
   [こちら](https://learn.hashicorp.com/tutorials/terraform/install-cli#install-terraform)を参考にインストールを行う

2. Initialize

   ```sh
   terraform init
   ```

3. apply

   ```sh
   terraform apply
   ```
