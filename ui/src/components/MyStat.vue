<template>
    <div class="mystats w-[100%] h-[80px] bg-[var(--bg-color)] rounded-t-[30px] flex justify-start align-center gap-[25%]">
        <div class="profile mx-[30px]">
            <div class="pfp w-[50px] h-[50px] cursor-pointer" @click="changeProfile()"><img :src="logo" alt="" class="w-[100%] rounded-[50%]"></div>
            <div class="profileBox">
                <div class="titles">{{ name }}</div>
                <div class="titles mini text-[13px]"># {{ rank }}</div>
            </div>
        </div>
        <div class="w-[50%] statBox flex justify-between align-center">
            <div class="titles flex justify-center align-center gap-[5px]"><i class="fa-solid fa-skull"></i> Kills: <span class="text-[var(--primary-color)]">{{ kills }}</span></div>
            <div class="titles flex justify-center align-center gap-[5px]"><i class="fa-solid fa-skull-crossbones"></i> Death:  <span class="text-[var(--primary-color)]">{{ deaths }}</span></div>
            <div class="titles flex justify-center align-center gap-[5px]"><i class="fa-solid fa-medal"></i> KD: <span class="text-[var(--primary-color)]">{{ kd }}</span></div> 
        </div>
    </div>
</template>
  
<script>
    export default{
        name: 'MyStat',
        props: {
            kills: Number,
            deaths: Number,
            kd: Number,
            name: String,
            rank: Number,
            logo: String
        },
        methods: {
            changeProfile(){
                this.$emit('change-profile', true)
            }
        },
        emits: ['change-profile']
    }
</script>

<style>
.profile{
    width: fit-content;
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: row;
    gap: 10px;
}
.profileBox{
    width: fit-content;
    display: flex;
    justify-content: center;
    align-items: flex-start;
    flex-direction: column;
    gap: 0px;
}
.pfp img{
    position: relative;
    transition: 0.3s;
}
.pfp img:hover{
    opacity: 0.6;
}
</style>
