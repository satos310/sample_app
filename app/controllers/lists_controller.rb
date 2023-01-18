class ListsController < ApplicationController
  def new
    # Viewへ渡すためのインスタンス変数に空のModelオブジェクトを生成する。
    @list = List.new
  end
  
  def create
    # データを受け取り、新規登録するためのインスタンスを作成
    @list = List.new(list_params)
    # データをデータベースに保存するためのsaveメソッド実行
    if @list.save
      # 詳細画面へリダイレクト
      redirect_to list_path(@list.id)
    else
      render :new
    end
  end

  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
  end

  # 投稿済のデータを編集
  def edit
    @list = List.find(params[:id])
  end
  
  #データの更新後に更新結果を詳細画面に表示するために、showアクションにリダイレクトさせる。
  def update
    list = List.find(params[:id])
    list.update(list_params)
    redirect_to list_path(list.id)
  end
  
  def destroy
    list = List.find(params[:id])
    list.destroy
    redirect_to '/lists'
  end
  
  private
  
  def list_params
    params.require(:list).permit(:title, :body, :image)
  end
end
