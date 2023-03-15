<template>
    <div class="stats flex justify-between align-center">
        <div class="flex justify-left align-center gap-[5px]">
            <div v-if="statIconNumber==1"><i class="fa-solid fa-skull"></i></div>
            <div v-if="statIconNumber==2"><i class="fa-solid fa-skull-crossbones"></i></div>
            <div v-if="statIconNumber==3"><i class="fa-solid fa-medal"></i></div>
            <div>{{ statName }}</div>
        </div>
        <div class="statData flex justify-right align-center gap-[5px] pl-[5px] font-bold">{{ statData }}</div>
    </div>
</template>
  
<script>
    export default{
        name: 'Stats',
        props:{
            statName: String,
            statIconNumber: String,
            statData: Number
        }
    }
</script>
