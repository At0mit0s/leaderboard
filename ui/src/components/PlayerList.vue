<template>
    <div class="w-[100%] h-[100%] bg-[rgba(23,23,23,0.3)] mt-[10px]">
        <div class="w-[100%] h-[60px] flex justify-between align-center flex-row border-[var(--primary-color)] border-b-[2px] bg-[var(--bg-color)]">
            <div class="titles textShadow w-[10%]">Rank</div>
            <div class="titles textShadow w-[40%]">Player</div>
            <div class="titles textShadow w-[20%]">Kill</div>
            <div class="titles textShadow w-[20%]">Death</div>
            <div class="titles textShadow w-[15%]">KD</div>
        </div>
        <div class="leaderboardTable h-[90%] overflow-auto">
            <div v-for="data, index in this.leaderboardDatas" class="row w-[100%] h-[60px] flex justify-between align-center flex-row">
                <div v-if="data.name == name"  class="row w-[100%] h-[60px] flex justify-between align-center flex-row">
                    <div class="titles w-[10%] text-[var(--primary-color)]"># {{ index + 1}}</div>
                    <div class="titles w-[40%] text-[var(--primary-color)]">{{ data.name }}</div>
                    <div class="titles w-[20%] text-[var(--primary-color)]">{{ data.kills }}</div>
                    <div class="titles w-[20%] text-[var(--primary-color)]">{{ data.deaths }}</div>
                    <div class="titles w-[15%] text-[var(--primary-color)]">{{ data.kd }}</div>
                </div>
                <div v-else class="row w-[100%] h-[60px] flex justify-between align-center flex-row">
                    <div class="titles w-[10%]"># {{ index + 1 }}</div>
                    <div class="titles w-[40%]">{{ data.name }}</div>
                    <div class="titles w-[20%]">{{ data.kills }}</div>
                    <div class="titles w-[20%]">{{ data.deaths }}</div>
                    <div class="titles w-[15%]">{{ data.kd }}</div>
                </div>
            </div>
        </div>
    </div>
</template>
  
<script>
    export default{
        name: 'PlayerList',
        props:{
            leaderboardDatas: Array,
            name: String
        },
    }
</script>

<style>
.textShadow{
    text-shadow: 3px 3px 0px var(--primary-color) !important;
}
.titles{
    height: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    font-weight: 700;
    text-transform: uppercase;
    text-shadow: 3px 3px 0px black;
    text-align: center;
}
.row:nth-child(odd){
    background-color: var(--bg-color-overlay);
    opacity: 0.8;
}
.row:nth-child(even){
    background-color: transparent;
    opacity: 0.8;
}
</style>