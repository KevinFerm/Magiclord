class BattlesController < ApplicationController
  before_action :set_battle, only: [:show, :edit, :update, :destroy]

  # GET /battles
  # GET /battles.json
  def index
    if session[:battle]
      @battles = Battle.all
      @battle_id = 0
      @user_char = current_user.characters.where(Status: 1).first
      chars = []
      items = []
      @pearls = []

      @teams = []
      found_team = {}
      @battles.each do |battle|
        teams = JSON.parse(battle.contestant)
        teams.each do |players|
          players.each do |player|
            player[1].each do |p|
              if p["id"] == @user_char.id and p["npc"] == false
                @battle_id = battle.id
                @found_team = teams
                @user_char.inventories.each do |inv|
                  inv.items.each do |item|
                    item.pearls.each do |pearl|
                      @pearls << pearl
                    end
                  end
                end
              end
            end
          end
        end
      end
      if @found_team
        @found_team.each do |players|
          players.each do |player|
            player[1].each do |p|
              if p["id"]
                if p["npc"]
                  player = Npc.find(p["id"])
                  chars << {player: player }
                else
                  player = Character.find(p["id"])
                  player.inventories.each do |inv|
                    inv.items.each do |item|
                      items << item
                    end
                  end
                  chars << {player: player, equip: items}
                  items = []
                end
              end
            end
          end
          @teams << chars
          chars = []
        end
      end
    else
      redirect_to(worlds_path)
    end
  end

  def escape
    session[:battle] = false
    battle = Battle.find(params[:battle_id])
    all = JSON.parse(battle.contestant)
    for i in 0..all.length-1
      puts all[i].inspect
      for j in 0..all[i]['players'].length-1
        puts(all[i]['players'][j].inspect)
        if all[i]['players'][j]['id'].to_i == params[:player_id].to_i && !all[i]['players'][j]['npc']
            if all[i]['players'].length > 1
              all[i]['players'].delete_at(j)
            else
              all.delete_at(i)
            end
            all = all.to_s
            all = all.gsub! '=>', ':'
            all = all.gsub! 'nil', 'null'
            battle.contestant = all.to_s
            battle.save
            redirect_to worlds_path
            return
        end
      end
    end
    redirect_to worlds_path
  end

  def join
    if params[:target_id] != 'undefined'
      target_split = params[:target_id].split('_')
      battle = Battle.find(params[:battle_id])
      all = JSON.parse(battle.contestant)
      me = find_player(all,params[:player_id], "false")
      npc = "false";
      if target_split[0] == "npc"
        npc = "true"
      end
      target = find_player(all,target_split[1], npc)
      all[target[:team]]['players'] << {"id" => me[:player], "npc" => false, "attack" => {"id" => 0, "target" => 0,"npc" => nil}}
      if all[me[:team]]['players'].length > 1
        all[me[:team]]['players'].delete_at(me[:poss])
      else
        all.delete_at(me[:team])
      end
      all = all.to_s
      all = all.gsub! '=>', ':'
      all = all.gsub! 'nil', 'null'
      battle.contestant = all.to_s
      battle.save
    end
    redirect_to battles_path
  end

  def find_player(all, id, npc)
    for i in 0..all.length-1
      for j in 0..all[i]['players'].length-1
        if all[i]['players'][j]['id'].to_s == id && all[i]['players'][j]['npc'].to_s == npc
          return {:team => i, :player => all[i]['players'][j]['id'], :poss => j}
        end
      end
    end
  end

  # GET /battles/1
  # GET /battles/1.json
  def show
  end

  # GET /battles/new
  def new
    @battle = Battle.new
  end

  # GET /battles/1/edit
  def edit
  end

  # POST /battles
  # POST /battles.json
  def create
    @battle = Battle.new(battle_params)

    respond_to do |format|
      if @battle.save
        format.html { redirect_to @battle, notice: 'Battle was successfully created.' }
        format.json { render :show, status: :created, location: @battle }
      else
        format.html { render :new }
        format.json { render json: @battle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /battles/1
  # PATCH/PUT /battles/1.json
  def update
    respond_to do |format|
      if @battle.update(battle_params)
        format.html { redirect_to @battle, notice: 'Battle was successfully updated.' }
        format.json { render :show, status: :ok, location: @battle }
      else
        format.html { render :edit }
        format.json { render json: @battle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /battles/1
  # DELETE /battles/1.json
  def destroy
    @battle.destroy
    respond_to do |format|
      format.html { redirect_to battles_url, notice: 'Battle was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_battle
      @battle = Battle.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def battle_params
      params.require(:battle).permit(:contestant, :phase, :location)
    end
end
