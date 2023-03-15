<template>
  <div class="kdSystem animate__animated animate__fadeIn" v-if="kdVisible">
    <div class="kdContent min-w-[200px] w-fit h-fit p-[10px] flex justify-between align-center bg-[var(--bg-color-overlay)] rounded-[3px] border-b-[2px] border-[var(--primary-color)] shadow-[0px 10px 30px var(--primary-color)]">
      <div class="w-[100%] flex justify-between align-center flex-col gap-[10px]">
        <Stats statName="Kills:" statIconNumber="1" :statData="playerData.kills"/>
        <Stats statName="Death:" statIconNumber="2" :statData="playerData.deaths"/>
        <Stats statName="KD:" statIconNumber="3" :statData="playerData.kd"/>
      </div>
    </div>
  </div>
  <div class="leaderboard animate__animated w-[70%] h-[55.5%] mb-[10%]" :class="[animationState ? 'animate__zoomIn' : 'animate__zoomOut']" v-if="leaderboardVisible">
    <MyStat :kills="playerData.kills" :deaths="playerData.deaths" :kd="playerData.kd" :name="playerData.name" :rank="myRank" :logo="logo" @change-profile="changeUrl"/>
    <PlayerList :leaderboardDatas="allPlayerData" :name="playerData.name"/>
  </div>

  <div class="changeProfile absolute w-[100%] h-[100%] bg-[rgb(0,0,0,0.6)]" v-if="changeProfileActive">
      <div class="changeProfileContent w-[25%] h-[10%] bg-[var(--bg-color)] border-[2px] border-[var(--primary-color)] rounded absolute top-[50%] left-[50%] translate-x-[-50%] translate-y-[-50%]">
          <input class="text-[rgb(255,255,255)] p-[5px] w-[60%]" type="text" placeholder="url..." v-model="logoURL">
          <div class="w-[30%] h-[30px] p-[5px] text-center bg-[var(--primary-color)] rounded cursor-pointer" @click="saveProfile()">Save</div>
      </div>
  </div>
</template>

<script>
import { onMounted } from 'vue';
import Stats from './components/Stats.vue'
import PlayerList from './components/PlayerList.vue'
import MyStat from './components/MyStat.vue'
export default{
  name: 'App',
  components: {
    Stats,
    PlayerList,
    MyStat
  },
  data(){
    return{
      kdVisible: false,
      leaderboardVisible: false,
      animationState: false,
      playerData: [{kills: 0, deats: 0, kd: 0, name: 'Loading...'}],
      allPlayerData: [],
      myRank: 0,
      logo: "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Default_pfp.svg/2048px-Default_pfp.svg.png",
      changeProfileActive: false,
      logoURL: ''
    }
  },
  methods:{
    changeUrl(){
      this.changeProfileActive = true
    },
    saveProfile(){
      if(this.logoURL != ''){
        localStorage.setItem(this.playerData.name, this.logoURL)
        this.changeProfileActive = false
        this.logo = this.logoURL
        this.logoURL = ''
      }
    }
  },
  mounted(){
    window.addEventListener('message', (event)=> {
      let data = event.data;

      if(data.action == 'showKD'){
        this.kdVisible = true
      }

      if(data.action == 'hideKD'){
        this.kdVisible = false
      }

      if(data.action == 'leaderboardEnable'){
        this.leaderboardVisible = true
        this.animationState = true
      }

      if(data.action == 'leaderboardDisable'){
        this.leaderboardVisible = false
      }

      if(data.action == 'playerDataActive'){
        this.playerData = data.playerDataActive
        if(localStorage.getItem(this.playerData.name) != null){
          this.logo = localStorage.getItem(this.playerData.name)
        }
      }

      if(data.action == 'allPlayerDataActive'){
        this.allPlayerData = data.allPlayerData
      }

      if(data.myRank != undefined){
        this.myRank = data.myRank
      }

      if(data.action == 'loadConfig'){
        if(data.colorTheme != undefined){
          document.documentElement.style.setProperty('--primary-color', data.colorTheme)
        }
        else{
          document.documentElement.style.setProperty('--primary-color', '#428dff')

        }
      }

    });

    window.addEventListener('keydown', (event)=>{
      if(event.key == 'Escape'){
        this.animationState = false
        this.changeProfileActive = false
        setTimeout(() => {
          fetch(`https://${GetParentResourceName()}/hideLeaderboard`).catch(function(){return})
          fetch(`https://${GetParentResourceName()}/setNuiFocusDisable`).catch(function(){return})
        }, 500);
      }
    });

    $( function() {
        $( ".kdSystem" ).draggable();
    });
  }
}
</script>

<style>
@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;700&display=swap');
:root{
  --bg-color: #171717;
  --bg-color-overlay: rgba(23, 23, 23, 0.6);
  --primary-color: #428dff;
}
 /* width */
 ::-webkit-scrollbar {
  width: 5px;
}

/* Track */
::-webkit-scrollbar-track {
  background: var(--bg-color-overlay);
  border-radius: 10px;
}

/* Handle */
::-webkit-scrollbar-thumb {
  background: var(--primary-color);
  border-radius: 10px;
}
*{
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: 'Poppins', sans-serif;
  color: white;
}
body{
  width: 100%;
  height: 100vh;
  overflow: hidden;
  user-select: none;
}
#app{
  width: 100%;
  height: 100vh;
  overflow: hidden;
  display: flex;
  justify-content: center;
  align-items: center;
}
.kdSystem{
  position: absolute;
  top: 30px;
  right: 30px;
  z-index: 100;
}
.settingOverlay{
  position: relative;
  display: flex;
  justify-content: center;
  align-items: center;
  text-transform: uppercase;
  font-weight: 700;
  font-size: 60px;
  color: rgba(255,255,255,0.3);
}
.changeProfileContent{
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
  gap: 10px;
}
input{
  background-color: transparent;
  border-left: 3px solid rgba(255,255,255,0.3);
  border-right: 3px solid rgba(255,255,255,0.3);
  border-top: 2px solid rgba(255,255,255,0.1);
  border-bottom: 2px solid rgba(255,255,255,0.1);
  border-radius: 5px;
  text-align: center;
}
input::placeholder{
  text-align: center;
  text-transform: uppercase;
}
input:focus{
  outline: none;
}
</style>